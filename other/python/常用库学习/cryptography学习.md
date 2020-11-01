# cryptography学习
```python
import secrets
import base64
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.primitives import padding, serialization
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives.asymmetric import rsa, padding

msg = 'Hello, world! 你好， 世界!'

# 
#   AES
# 
msg_bytes = msg.encode()
key_bytes = secrets.token_bytes(16)
iv_bytes = secrets.token_bytes(16)
backend = default_backend()
cipher = Cipher(algorithms.AES(key_bytes), modes.CBC(iv_bytes), backend=backend)
# encrypt
encryptor = cipher.encryptor()
padder = padding.PKCS7(128).padder()
padded_bytes = padder.update(msg_bytes) + padder.finalize()
encrypted_bytes = encryptor.update(padded_bytes) + encryptor.finalize()
encrypted_b64 = base64.b64encode(encrypted_bytes).decode() 
# decrypt
decryptor = cipher.decryptor()
unpadder_bytes = decryptor.update(encrypted_bytes) + decryptor.finalize()
unpadder = padding.PKCS7(128).unpadder()
decrypted_bytes = unpadder.update(unpadder_bytes) + unpadder.finalize()
decrypted_msg = decrypted_bytes.decode()

print(f'key: {key_bytes.hex()}')
print(f'iv: {iv_bytes.hex()}')
print(f'encrypted_b64: {encrypted_b64}')
print(f'decrypted_msg: {decrypted_msg}')

# 
# RSA
# 
# Generate key pair
private_key = rsa.generate_private_key(
    public_exponent = 65537,
    key_size = 2048,
    backend = default_backend()
)
private_bytes = private_key.private_bytes(
    encoding = serialization.Encoding.PEM,
    format = serialization.PrivateFormat.PKCS8,
    encryption_algorithm = serialization.NoEncryption()
)
public_key = private_key.public_key()
public_bytes = public_key.public_bytes(
    encoding = serialization.Encoding.PEM,
    format = serialization.PublicFormat.PKCS1
)
# save files
with open('private.pem', 'wb') as private_key_file:
    private_key_file.write(private_bytes)
with open('public.pem', 'wb') as public_key_file:
    public_key_file.write(public_bytes)
# load from file
with open("private.pem", "rb") as key_file:
    private_key_new = serialization.load_pem_private_key(
    key_file.read(),
    password=None,
    backend=default_backend()
)
# encrypt
encrypt_bytes = public_key.encrypt(
    msg.encode(),
    padding.PKCS1v15()
)
# decrypt
decrypt_bytes = private_key_new.decrypt(
    encrypt_bytes,
    padding.PKCS1v15()
    
)
print(f'{encrypt_bytes.hex()}\n{decrypt_bytes.decode()}')
```