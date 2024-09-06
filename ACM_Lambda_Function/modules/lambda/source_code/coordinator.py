import boto3
import json

def lambda_handler(event, context):
    # Lista de ARNs das funções Lambda a serem executadas
    function_arns = [
        #add here the list of acm worker functions that will be invoked by the coordinator
    ]

    # Crie um cliente Lambda para invocar as funções
    lambda_client = boto3.client('lambda')

    # Dicionário para armazenar os outputs das funções por função
    function_outputs = {}
    # Lista para armazenar as funções bem-sucedidas e falhas
    successful_functions = []
    failed_functions = []

    # Iterar sobre cada ARN de função na lista
    for function_arn in function_arns:
        try:
            # Invocar a função Lambda
            response = lambda_client.invoke(
                FunctionName=function_arn,
                InvocationType='RequestResponse'
            )
            # Obter o output da função e adicionar ao dicionário de outputs
            output = json.loads(response['Payload'].read().decode("utf-8"))
            function_outputs[function_arn] = output
            successful_functions.append(function_arn)
        except Exception as e:
            # Se ocorrer uma exceção, registre a falha e continue para a próxima função
            print(f"A funcao {function_arn} falhou: {str(e)}")
            failed_functions.append(function_arn)
            continue

    # Exibir funções bem-sucedidas e falhas
    print("Funções bem-sucedidas:")
    for function_arn in successful_functions:
        print(function_arn)
    print("Funções que falharam:")
    for function_arn in failed_functions:
        print(function_arn)

    # Verificar se há certificados para enviar
    certificates_exist = any(output for output in function_outputs.values() if output)
    if not certificates_exist:
        return {
            'statusCode': 200,
            'body': json.dumps('Todos os certificados OK. Nenhum alerta deve ser enviado.')
        }

    # Crie um cliente SNS para publicar a mensagem no tópico SNS
    sns_client = boto3.client('sns')

    # Formatar a mensagem para o tópico SNS
    message = "Resultados das funções Lambda:\n"
    for function_arn, output in function_outputs.items():
        if output:
            for certificate_info in output:
                message += f"Certificate ARN: {certificate_info['CertificateArn']}\n"
                message += f"AWS Account: {certificate_info['AccountName']} - ({certificate_info['AccountId']})"
                message += f" - \n"
                message += f"Expiration Date: {certificate_info['ExpirationDate']}"
                message += f" - \n"
                message += f"Days Until Expiration: {certificate_info['DaysUntilExpiration']}"
                message += f" - \n"
                message += f"{certificate_info.get('RenewalStatus', 'Não foi possível renovar')}\n"
                message += f" ---------------------\n"

    # Envie a mensagem formatada para o tópico SNS
    sns_client.publish(
        TopicArn='',
        Subject='[ATENÇÃO] - Certificados ACM Expirando',
        Message=message
    )

    return {
        'statusCode': 200,
        'body': json.dumps('Responsaveis acionados por email via SNS.')
    }
