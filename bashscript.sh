#!/bin/bash

# Function to generate private key if not exists
generate_private_key() {
    if [ ! -f "/home/dipeshbadal/private_key.pem" ]; then
        openssl genpkey -algorithm RSA -out /home/dipeshbadal/private_key.pem
        echo "Private key generated successfully."
    else
        echo "Private key already exists."
    fi
}

# Function to generate recipient's public key if not exists
generate_recipient_public_key() {
    if [ ! -f "/home/dipeshbadal/recipient_public_key.pem" ]; then
        openssl rsa -pubout -in /home/dipeshbadal/private_key.pem -out /home/dipeshbadal/recipient_public_key.pem
        echo "Recipient's public key generated successfully."
    else
        echo "Recipient's public key already exists."
    fi
}

# Function to generate file
generate_file() {
    echo "This is some data for the file." > /home/dipeshbadal/file.txt
    echo "File generated successfully."
}

# Function to generate digital signature
generate_signature() {
    openssl dgst -sha256 -sign /home/dipeshbadal/private_key.pem -out /home/dipeshbadal/signature.txt /home/dipeshbadal/file.txt
    echo "Digital signature generated successfully."
}

# Function to encrypt data and forward
encrypt_and_forward() {
    # Encrypt data
    openssl pkeyutl -encrypt -pubin -inkey /home/dipeshbadal/recipient_public_key.pem -in /home/dipeshbadal/file.txt -out /home/dipeshbadal/encrypted_data.enc
    echo "Data encrypted successfully."

    # Forward encrypted data (example: via email)
    # Replace recipient_email with the actual email address of the recipient
    mail -s "Encrypted Data" recipient_email < /home/dipeshbadal/encrypted_data.enc
    echo "Encrypted data forwarded successfully."
}

# Function to decrypt data
decrypt_data() {
    # Decrypt data using private key
    openssl pkeyutl -decrypt -inkey /home/dipeshbadal/private_key.pem -in /home/dipeshbadal/encrypted_data.enc -out /home/dipeshbadal/decrypted_data.txt
    echo "Data decrypted successfully."
}

# Main function to execute the steps
main() {
    generate_private_key
    generate_recipient_public_key
    generate_file
    generate_signature
    encrypt_and_forward
    decrypt_data
}

# Execute main function
main
