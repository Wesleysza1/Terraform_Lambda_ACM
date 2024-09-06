import boto3
import datetime
from dateutil.tz import tzlocal

def get_account_name(account_id):
    # Dicionário de contas com seus nomes correspondentes
    account_names = {
        #Map aws accounts in your environment
        #account_id: account_name
    }
    return account_names.get(account_id, 'Nome_Desconhecido')

def lambda_handler(event, context):
    # Inicializa o cliente ACM na região us-east-1
    acm_client_us_east_1 = boto3.client('acm', region_name='us-east-1')
    # Inicializa o cliente ACM na região sa-east-1
    acm_client_sa_east_1 = boto3.client('acm', region_name='sa-east-1')

    # Obtém a data atual como uma data consciente do fuso horário local
    current_date = datetime.datetime.now(tzlocal())
    
    # Obtém o ID da conta AWS
    aws_account_id = boto3.client('sts').get_caller_identity()['Account']
    aws_account_name = get_account_name(aws_account_id)
    
    # Lista para armazenar os certificados com validade menor do que 50 dias
    certificates_near_expiration = []
    
    # Lista os certificados ACM na região us-east-1
    certificates_us_east_1 = acm_client_us_east_1.list_certificates()['CertificateSummaryList']
    # Lista os certificados ACM na região sa-east-1
    certificates_sa_east_1 = acm_client_sa_east_1.list_certificates()['CertificateSummaryList']
    
    # Itera sobre os certificados da região us-east-1 para verificar a validade
    for cert in certificates_us_east_1:
        # Verifica se o status do certificado é "ISSUED"
        if cert['Status'] == 'ISSUED':
            cert_details = acm_client_us_east_1.describe_certificate(CertificateArn=cert['CertificateArn'])
            
            # Obtém a data de expiração do certificado
            expiration_date = cert_details['Certificate']['NotAfter'].astimezone(tzlocal())
            
            # Calcula os dias restantes até a expiração
            days_until_expiration = (expiration_date - current_date).days
            
            # Verifica se o certificado está a menos de 50 dias de expirar
            if days_until_expiration <= 50:
                # Formata os dados do certificado para saída
                certificate_output = {
                    'CertificateArn': cert_details['Certificate']['CertificateArn'],
                    'AccountName': aws_account_name,
                    'AccountId': aws_account_id,
                    'ExpirationDate': expiration_date.strftime("%d-%m-%Y"),
                    'DaysUntilExpiration': days_until_expiration
                }
                # Tentativa de renovar o certificado
                renewal_status = renew_certificate(acm_client_us_east_1, cert_details['Certificate']['CertificateArn'])
                certificate_output['RenewalStatus'] = 'Renewal Successful' if renewal_status else 'Renewal Failed'
                certificates_near_expiration.append(certificate_output)
        else:
            print(f"O certificado {cert['CertificateArn']} não está disponível para consulta.")

    # Itera sobre os certificados da região sa-east-1 para verificar a validade
    for cert in certificates_sa_east_1:
        # Verifica se o status do certificado é "ISSUED"
        if cert['Status'] == 'ISSUED':
            cert_details = acm_client_sa_east_1.describe_certificate(CertificateArn=cert['CertificateArn'])
            
            # Obtém a data de expiração do certificado
            expiration_date = cert_details['Certificate']['NotAfter'].astimezone(tzlocal())
            
            # Calcula os dias restantes até a expiração
            days_until_expiration = (expiration_date - current_date).days
            
            # Verifica se o certificado está a menos de 50 dias de expirar
            if days_until_expiration <= 50:
                # Formata os dados do certificado para saída
                certificate_output = {
                    'CertificateArn': cert_details['Certificate']['CertificateArn'],
                    'AccountName': aws_account_name,
                    'AccountId': aws_account_id,
                    'ExpirationDate': expiration_date.strftime("%d-%m-%Y"),
                    'DaysUntilExpiration': days_until_expiration
                }
                # Tentativa de renovar o certificado
                renewal_status = renew_certificate(acm_client_sa_east_1, cert_details['Certificate']['CertificateArn'])
                certificate_output['RenewalStatus'] = 'Renewal Successful' if renewal_status else 'Renewal Failed'
                certificates_near_expiration.append(certificate_output)
        else:
            print(f"O certificado {cert['CertificateArn']} não está disponível para consulta.")
    
    # Retorna os certificados com validade menor do que 50 dias
    return certificates_near_expiration

def renew_certificate(acm_client, certificate_arn):
    try:
        acm_client.renew_certificate(CertificateArn=certificate_arn)
        return True
    except Exception as e:
        print(f"Erro ao renovar o certificado {certificate_arn}: {str(e)}")
        return False