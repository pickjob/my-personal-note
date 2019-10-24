# HMAC(Keyed-hash Message Authentication Code)学习
- 公式
  - HMAC(k, m) = H( (K' XOR opad) || H( (K' XOR ipad) || m ) )
  - H: Hash函数(MD5、SHA1)
  - K: key-secret
  - K': K < blocksize, K + 0x0; k > blocksize, H(k)
  - m: message
  - ||: 代表串接
  - opad: 0x5c{blocksize}
  - ipad: 0x36{blocksize}
    ```c
        function hmac (key, message) {
            if (length(key) > blocksize) {
                key = hash(key) // keys longer than blocksize are shortened
            }
            if (length(key) < blocksize) {
                // keys shorter than blocksize are zero-padded (where ∥ is concatenation)
                key = key ∥ [0x00 * (blocksize - length(key))] // Where * is repetition.
            }
        
            o_key_pad = [0x5c * blocksize] XOR key // Where blocksize is that of the underlying hash function
            i_key_pad = [0x36 * blocksize] XOR key // Where ⊕ is exclusive or (XOR)

            return hash(o_key_pad ∥ hash(i_key_pad ∥ message)) // Where ∥ is concatenation
        }
    ```
- Hash算法比较
MD5                  128             128(4*32)    512               64
SHA-1                160             160(5*32)    512               80
SHA-224/256          224/256         256(8*32)    521               64
SHA-384/512          384/512         512(8*64)    1024              80
SHA3-224/256/384/512 224/256/384/512 1600(5*5*64) 1152/1088/832/576 24