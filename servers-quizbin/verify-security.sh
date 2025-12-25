#!/usr/bin/env bash

openssl s_client -connect mail.quizbin.com:25 -tls1
# CONNECTED(00000003)
# 401714A595770000:error:0A00010B:SSL routines:ssl3_get_record:wrong version number:../ssl/record/ssl3_record.c:354:
# ---
# no peer certificate available
# ---
# No client certificate CA names sent
# ---
# SSL handshake has read 5 bytes and written 129 bytes
# Verification: OK
# ---
# New, (NONE), Cipher is (NONE)
# Secure Renegotiation IS NOT supported
# Compression: NONE
# Expansion: NONE
# No ALPN negotiated
# SSL-Session:
#     Protocol  : TLSv1
#     Cipher    : 0000
#     Session-ID:
#     Session-ID-ctx:
#     Master-Key:
#     PSK identity: None
#     PSK identity hint: None
#     SRP username: None
#     Start Time: 1766650179
#     Timeout   : 7200 (sec)
#     Verify return code: 0 (ok)
#     Extended master secret: no
# ---

docker run --rm -ti drwetter/testssl.sh --starttls smtp mail.quizbin.com:587
# #####################################################################
#   testssl.sh version 3.2.2 from https://testssl.sh/
#
#   This program is free software. Distribution and modification under
#   GPLv2 permitted. USAGE w/o ANY WARRANTY. USE IT AT YOUR OWN RISK!
#
#   Please file bugs @ https://testssl.sh/bugs/
# #####################################################################
#
#   Using OpenSSL 1.0.2-bad (Mar 28 2025)  [~183 ciphers]
#   on 010a87bdae60:/home/testssl/bin/openssl.Linux.x86_64
#
#  Start 2025-12-25 08:18:28        -->> 129.213.114.77:587 (mail.quizbin.com) <<--
#
#  rDNS (129.213.114.77):  --
#  Service set:            STARTTLS via SMTP
#
#  Testing protocols via sockets
#
#  SSLv2      not offered (OK)
#  SSLv3      not offered (OK)
#  TLS 1      not offered
#  TLS 1.1    not offered
#  TLS 1.2    offered (OK)
#  TLS 1.3    offered (OK): final
#
#  Testing cipher categories
#
#  NULL ciphers (no encryption)                      not offered (OK)
#  Anonymous NULL Ciphers (no authentication)        not offered (OK)
#  Export ciphers (w/o ADH+NULL)                     not offered (OK)
#  LOW: 64 Bit + DES, RC[2,4], MD5 (w/o export)      not offered (OK)
#  Triple DES Ciphers / IDEA                         not offered
#  Obsoleted CBC ciphers (AES, ARIA etc.)            offered
#  Strong encryption (AEAD ciphers) with no FS       offered (OK)
#  Forward Secrecy strong encryption (AEAD ciphers)  offered (OK)
#
#
#  Testing server's cipher preferences
#
# Hexcode  Cipher Suite Name (OpenSSL)       KeyExch.   Encryption  Bits     Cipher Suite Name (IANA/RFC)
# -----------------------------------------------------------------------------------------------------------------------------
# SSLv2
#  -
# SSLv3
#  -
# TLSv1
#  -
# TLSv1.1
#  -
# TLSv1.2
#  (server order)
#  xc02f   ECDHE-RSA-AES128-GCM-SHA256       ECDH 253   AESGCM      128      TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
#  xc030   ECDHE-RSA-AES256-GCM-SHA384       ECDH 253   AESGCM      256      TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
#  xc027   ECDHE-RSA-AES128-SHA256           ECDH 253   AES         128      TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256
#  xc028   ECDHE-RSA-AES256-SHA384           ECDH 253   AES         256      TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
#  xcca8   ECDHE-RSA-CHACHA20-POLY1305       ECDH 253   ChaCha20    256      TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
#  xc061   ECDHE-ARIA256-GCM-SHA384          ECDH 253   ARIAGCM     256      TLS_ECDHE_RSA_WITH_ARIA_256_GCM_SHA384
#  xc060   ECDHE-ARIA128-GCM-SHA256          ECDH 253   ARIAGCM     128      TLS_ECDHE_RSA_WITH_ARIA_128_GCM_SHA256
#  xc014   ECDHE-RSA-AES256-SHA              ECDH 253   AES         256      TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
#  xc013   ECDHE-RSA-AES128-SHA              ECDH 253   AES         128      TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA
#  x9d     AES256-GCM-SHA384                 RSA        AESGCM      256      TLS_RSA_WITH_AES_256_GCM_SHA384
#  xc09d   AES256-CCM                        RSA        AESCCM      256      TLS_RSA_WITH_AES_256_CCM
#  xc051   ARIA256-GCM-SHA384                RSA        ARIAGCM     256      TLS_RSA_WITH_ARIA_256_GCM_SHA384
#  x9c     AES128-GCM-SHA256                 RSA        AESGCM      128      TLS_RSA_WITH_AES_128_GCM_SHA256
#  xc09c   AES128-CCM                        RSA        AESCCM      128      TLS_RSA_WITH_AES_128_CCM
#  xc050   ARIA128-GCM-SHA256                RSA        ARIAGCM     128      TLS_RSA_WITH_ARIA_128_GCM_SHA256
#  x3d     AES256-SHA256                     RSA        AES         256      TLS_RSA_WITH_AES_256_CBC_SHA256
#  x3c     AES128-SHA256                     RSA        AES         128      TLS_RSA_WITH_AES_128_CBC_SHA256
#  x35     AES256-SHA                        RSA        AES         256      TLS_RSA_WITH_AES_256_CBC_SHA
#  x2f     AES128-SHA                        RSA        AES         128      TLS_RSA_WITH_AES_128_CBC_SHA
# TLSv1.3 (server order)
#  x1302   TLS_AES_256_GCM_SHA384            ECDH/MLKEM AESGCM      256      TLS_AES_256_GCM_SHA384
#  x1303   TLS_CHACHA20_POLY1305_SHA256      ECDH/MLKEM ChaCha20    256      TLS_CHACHA20_POLY1305_SHA256
#  x1301   TLS_AES_128_GCM_SHA256            ECDH/MLKEM AESGCM      128      TLS_AES_128_GCM_SHA256
#
#  Has server cipher order?     yes (OK) -- TLS 1.3 and below
#
#
#  Testing robust forward secrecy (FS) -- omitting Null Authentication/Encryption, 3DES, RC4
#
#  FS is offered (OK)           TLS_AES_256_GCM_SHA384 TLS_CHACHA20_POLY1305_SHA256 ECDHE-RSA-AES256-GCM-SHA384 ECDHE-RSA-AES256-SHA384 ECDHE-RSA-AES256-SHA ECDHE-RSA-CHACHA20-POLY1305
#                               ECDHE-ARIA256-GCM-SHA384 TLS_AES_128_GCM_SHA256 ECDHE-RSA-AES128-GCM-SHA256 ECDHE-RSA-AES128-SHA256 ECDHE-RSA-AES128-SHA ECDHE-ARIA128-GCM-SHA256
#  KEMs offered                 X25519MLKEM768
#  Elliptic curves offered:     prime256v1 secp384r1 secp521r1 X25519 X448
#  Finite field group:          ffdhe2048 ffdhe3072
#  TLS 1.2 sig_algs offered:    RSA-PSS-RSAE+SHA256 RSA-PSS-RSAE+SHA384 RSA-PSS-RSAE+SHA512 RSA+SHA256 RSA+SHA384 RSA+SHA512 RSA+SHA224
#  TLS 1.3 sig_algs offered:    RSA-PSS-RSAE+SHA256 RSA-PSS-RSAE+SHA384 RSA-PSS-RSAE+SHA512
#
#  Testing server defaults (Server Hello)
#
#  TLS extensions (standard)    "max fragment length/#1" "supported_groups/#10" "EC point formats/#11" "encrypt-then-mac/#22" "extended master secret/#23" "session ticket/#35"
#                               "supported versions/#43" "key share/#51" "renegotiation info/#65281"
#  Session Ticket RFC 5077 hint 7200 seconds, session tickets keys seems to be rotated < daily
#  SSL Session ID support       yes
#  Session Resumption           Tickets: yes, ID: no
#  TLS clock skew               Random values, no fingerprinting possible
#  Certificate Compression      none
#  Client Authentication        none
#  Signature Algorithm          SHA384 with RSA
#  Server key size              RSA 2048 bits (exponent is 65537)
#  Server key usage             Digital Signature, Key Encipherment
#  Server extended key usage    TLS Web Server Authentication
#  Serial                       EBC3334AE2F94C272D22E38A00538D52 (OK: length 16)
#  Fingerprints                 SHA1 6A3D4E6E9E5C79EAA8D347B3405A83863805A7DF
#                               SHA256 A4E3375B53A1861707FFC019B1B7CB2DB603C07DCF694A99EBE4575EE23FE197
#  Common Name (CN)             mail.quizbin.com
#  subjectAltName (SAN)         mail.quizbin.com
#  Trust (hostname)             Ok via SAN and CN (same w/o SNI)
#  Chain of trust               NOT ok (chain incomplete)
#  EV cert (experimental)       no
#  Certificate Validity (UTC)   expires < 60 days (32) (2025-10-28 00:00 --> 2026-01-26 23:59)
#  ETS/"eTLS", visibility info  not present
#  Certificate Revocation List  --
#  OCSP URI                     http://zerossl.ocsp.sectigo.com
#  OCSP stapling                not offered
#  OCSP must staple extension   --
#  DNS CAA RR (experimental)    not offered
#  Certificate Transparency     yes (certificate extension)
#  Certificates provided        1
#  Issuer                       ZeroSSL RSA Domain Secure Site CA (ZeroSSL from AT)
#  Intermediate Bad OCSP (exp.) Ok
#
#
#  Testing vulnerabilities
#
#  Heartbleed (CVE-2014-0160)                not vulnerable (OK), no heartbeat extension
#  CCS (CVE-2014-0224)                       not vulnerable (OK)
#  ROBOT                                     not vulnerable (OK)
#  Secure Renegotiation (RFC 5746)           supported (OK)
#  Secure Client-Initiated Renegotiation     VULNERABLE (NOT ok), potential DoS threat
#  CRIME, TLS (CVE-2012-4929)                not vulnerable (OK) (not using HTTP anyway)
#  POODLE, SSL (CVE-2014-3566)               not vulnerable (OK), no SSLv3 support
#  TLS_FALLBACK_SCSV (RFC 7507)              No fallback possible (OK), no protocol below TLS 1.2 offered
#  SWEET32 (CVE-2016-2183, CVE-2016-6329)    not vulnerable (OK)
#  FREAK (CVE-2015-0204)                     not vulnerable (OK)
#  DROWN (CVE-2016-0800, CVE-2016-0703)      not vulnerable on this host and port (OK)
#                                            make sure you don't use this certificate elsewhere with SSLv2 enabled services, see
#                                            https://search.censys.io/search?resource=hosts&virtual_hosts=INCLUDE&q=A4E3375B53A1861707FFC019B1B7CB2DB603C07DCF694A99EBE4575EE23FE197
#  LOGJAM (CVE-2015-4000), experimental      not vulnerable (OK): no DH EXPORT ciphers, no DH key detected with <= TLS 1.2
#  BEAST (CVE-2011-3389)                     not vulnerable (OK), no SSL3 or TLS1
#  LUCKY13 (CVE-2013-0169), experimental     potentially VULNERABLE, uses obsolete cipher block chaining ciphers with TLS, see server prefs.
#  Winshock (CVE-2014-6321), experimental    not vulnerable (OK)
#  RC4 (CVE-2013-2566, CVE-2015-2808)        no RC4 ciphers detected (OK)
#  STARTTLS injection (CVE-2011-0411, exp.)  not vulnerable (OK)
#
#
#  Running client simulations via sockets
#
#  Browser                      Protocol  Cipher Suite Name (OpenSSL)       Forward Secrecy
# ------------------------------------------------------------------------------------------------
#  Android 8.1 (native)         TLSv1.2   ECDHE-RSA-AES128-GCM-SHA256       253 bit ECDH (X25519)
#  Android 9.0 (native)         TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
#  Android 10.0 (native)        TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
#  Android 11/12 (native)       TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
#  Android 13/14 (native)       TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
#  Android 15 (native)          TLSv1.3   TLS_AES_256_GCM_SHA384            X25519MLKEM768
#  Java 7u25                    No connection
#  Java 8u442 (OpenJDK)         TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
#  Java 11.0.2 (OpenJDK)        TLSv1.3   TLS_AES_256_GCM_SHA384            256 bit ECDH (P-256)
#  Java 17.0.3 (OpenJDK)        TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
#  Java 21.0.6 (OpenJDK)        TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
#  go 1.17.8                    TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
#  LibreSSL 3.3.6 (macOS)       TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
#  OpenSSL 1.0.2e               TLSv1.2   ECDHE-RSA-AES128-GCM-SHA256       256 bit ECDH (P-256)
#  OpenSSL 1.1.1d (Debian)      TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
#  OpenSSL 3.0.15 (Debian)      TLSv1.3   TLS_AES_256_GCM_SHA384            253 bit ECDH (X25519)
#  OpenSSL 3.5.0 (git)          TLSv1.3   TLS_AES_256_GCM_SHA384            X25519MLKEM768
#
#
#  Rating (experimental)
#
#  Rating specs (not complete)  SSL Labs's 'SSL Server Rating Guide' (version 2009r from 2025-05-16)
#  Specification documentation  https://github.com/ssllabs/research/wiki/SSL-Server-Rating-Guide
#  Protocol Support (weighted)  0 (0)
#  Key Exchange     (weighted)  0 (0)
#  Cipher Strength  (weighted)  0 (0)
#  Final Score                  0
#  Overall Grade                T
#  Grade cap reasons            Grade capped to T. STARTTLS is prone to MITM downgrade attacks. A secure TLS upgrade can only be ensured client-side. As per RFC 8314 you should use implicit
#                                 TLS rather than STARTTLS. For SMTP (port 25) and SIEVE this is not possible.
#                               Grade capped to B. Issues with chain of trust (chain incomplete)
#
#  Done 2025-12-25 08:26:29 [ 484s] -->> 129.213.114.77:587 (mail.quizbin.com) <<--
#
