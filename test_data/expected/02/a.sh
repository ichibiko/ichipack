#!/bin/sh

####################################################################################################

if [ -z "$UID" ]; then
    UID=$(id -u)
fi
if [ -d /run/user/$UID ]; then
    export WORKING_DIR=$(mktemp -d /run/user/$UID/ichipack-XXXXXXXX)
elif [ -d /dev/shm ]; then
    export WORKING_DIR=$(mktemp -d /dev/shm/ichipack-XXXXXXXX)
else
    export WORKING_DIR=$(mktemp -d)
fi

trap "rm -rf $WORKING_DIR" EXIT

####################################################################################################

ichipack_generate_targets() {
mkdir etc

sed 's/^  //' <<\EOF_8e6cf332df4c2561194456db3386db50d5777738 | base64 -d > etc/binary-1.dat
  H4sICGc9alkAA2ljaGlwYWNrAK1WW2sbRxR+319xvFoq62G1siXLUhObmkRJRU0cjEwDcW12Z2e1
  i6WVshfbFD9UUqGB9qmklJZCMQ0tJKWh9KlQ8mcGh/yMzl5m75Zk4kVI2plz/86Z+UorkmKYkq1z
  nKHBUxC/BF74fG//s+6jh8f3u/s8fHEHHB2bHNAnFjno3k9veQ9d3BJWDRVEt+IvakZCTQXJck3J
  tbElefo5dXw+HlkOJLxTa8MTBw/HeW3JQLoxltGJ+CR8Apd4EHlT8SlNbHhjP6He9R5svKStqAqR
  TpF84kWqOo4lUb8DVRQEX2N4ohoWJIU4apBzLHkMvDUE0dIgjVjnSbfHcXk9ybYQZ2MVyrZ0BCBJ
  Zbh797Cz9+C41tSaSkNWEKq3W/Wm0m6omwrGLawqzTZqKa2a2sTyugbbOYPSwBYd2epjp0qbCIBj
  cGOosgIafXNk4QwOpdw+mX4P1b7hsNfJazL5kUx+B7oGSMcUiWjrj6s3b9//fUlmP5DpJZm+JLPX
  VP3q+curv34mk5/I9Fsy+ZVMJ9RI5I+pfEOmv5HZn2T6hsyek9krqkim/5DZCzL7LxQOiieO0+me
  yhZNNxRBrmVRrMdnIcoezqYKVbiAvoUp+qcgdqB8dFhdFS6kQy8x9iuFv0E2QqVMdZDrgKjURfr3
  jMKPwcKyCtpYdvQ7oI6ihounSfA3c92dTKAgeilQS4izidHmWxyYINogeGmHNpYzH54BQJMw2dwg
  dU5hPbQNk35t+5NouoMBQ+U01zNxGbnQFWvAFb8FPWPpfAKUuNQcfxByi+HK9a/4jB6hvjBfWGs0
  Mh3DdHFRGX3IkD6KLKTLqxnpZtq9d7yzu7t1D2zv3JkbbXy6B4YLGiETWBSUH1AEfRgKd5Ojhbvm
  ZFI0tdZeb9Q3am2MtMamqrTQxhpqtOtooy435fpGG2O0WXQyDWXDDA6lUnTL+f3R29l/2On5hy99
  2zvoPT7oHT/o7nYe7/Q+3Qpkgjo9BaEEYt+BmleMdKV4YY2HLeBFtahSCR/CemLd1g3NYVUbpA2N
  igxlw7vWWgQGW2QwJJGNw8r6SgRcLZylhC4rbcZE0JaPRg5oI9dUPy5S4WH7I5YBPqeDsZZ1lnHl
  j7A4yi3PvVyooRUPQqT7wxefJLnyBjF7QiaLOxliKsyoyul4TVrXDErZ4uJzjLwWzYglTCHZCXs+
  369LMLOF3KyAnSVaZkmGdkscbSmW9sE8LcPUluNqYU0SmjdnbIWcLUZ6EXPzhYI+oJ/VxJUZt3+w
  Fwz7fEp2S3wiGJMgr8OUw/QtlAR3AaHQZVunANi6vGa7QybLLi+xUavEWaZiFVb9a7p8VI6VzhCI
  gwo9JJ7RbW+WsjvFMcSp5W4f//oRvCDp4C5KmT3MikTNlCHHhdIuIwdFljyRLAbpdmZPCd798tXV
  2+8o1X334t/3l/QP/bwik6+T7HjJxDOZX4Ai27jZ8Ppj+SqEOhEEqarcWjlSjCjLMivxqVpwCUXk
  ZEl2wVF2UjBn7BbkhU94jvsf/5yHDUsPAAA=
EOF_8e6cf332df4c2561194456db3386db50d5777738

sed 's/^  //' <<\EOF_fe583595f85998dbd4b0a698e89a15a91911fc3a | base64 -d | gunzip - > etc/binary-2.dat
  H4sIAAAAAAAAA+1XW2vbVhzPsz7FP46Y4wdZdnxfm7DQpl1YaEpwWKFZgnR0FInYsivJSRh5mO3B
  CtvT6BgbgxFWNmjHytjTYPTLiJR+jB1dju6JHZoyBueHiKxz/vfLOf9YJhJ1pOlDCR0tvCdUCFqt
  hvuuthqV+NvbalRrC9VatbZSrzUb9dZCpbrSbDUXoPK+DIpjZNmSCbBwhA3yXE43a/9/iqVFUdYN
  0dI4TlfhMQifQ4H/dHvnk80H9w/ubu4U4LNbYGvY4IAgItndvJvcckEWV/llXQFhVPIWVT3GpoBo
  jgxxZGFTdPkz7Ph0ODBtiGkn0vpHNu4Ps9xh1QqPAvgqcS/UpuBj4lj/2noCvss1WHhOWWEUQp48
  +tiHWLZtUyR6e4rA8x5H/0jRTYgTcUQgZ5vSEApmHwRThWTGNh5tdjkuyydaJuIsrEDREvcBRLEI
  t2/vbWzfO6g01aZcl2SEap12rSl36kpLxriNFbnZQW25XVGaWFpRYS0jUOxZAumgQ2yXSREBcDTd
  GMo0gPqhMTBxKg9LmX1n8i2UD3Wbfo5fOuPvnfGvQNYAaZhkItz67eLV67d/njvT75zJuTN57kxf
  EvaLp88v/vjRGf/gTL52xj87kzEREuqjLF85k1+c6e/O5JUzfepMXxBGZ/KXM33mTP8JiP3gCcOk
  u8eSSdwNSNDINEmuhydBlt08GwqU4QwOTUyyfwzCBhT398rL/Jm45zpG32Lw9r3hS0XCg0Y2CHJN
  ID9PSPoxmFhSQB1KtnYLlEFYcFE38d5mprrjDuRYL/psMXLaMerVEnsGCBbwrtuBjPnEB2cAECcM
  2jdIuSKwbrZ1g/xZ8zrRGPV6NCvHmZqJwsgFqmgBLnol6ApL+uNniUv08Ttlbna6MvUrPCFHqEdc
  yI01Ghi2boxwXhi9lCFtEEpIhlfVk8W0dedgfWtr9Q5Y7rlzpbXR6e4LzimElGGhUZ5BYeoDU7jr
  HC3cJSeTrCqVDpkMGpUORmq9pcht1KiieqeGGjWpKdUaHYxRK+9k6ku64R9K0S3n1Ud3fef+Rtc7
  fMnX9m734W734N7m1sbD9e7Hqz6NH6fHwC+BcGhDxQ1GMlIFvlqAVSgISl6kYjr4ldi6pemqTaPW
  Swoa5AlKm3eptDAZdJGmIZ7ZyKy0rpjB5dxeivHS0KZE+GX5YGCDOhgZyod5LAVY+4B6gE9JY1TT
  ylKqvBYWBpnlKy8XImjRTSHSvOaLTpJMeH2bXSKD2h03MWFmGOWkvQaJaypL6eDiU4zcEk2RxUQh
  yQ5qPluvc0xmM2eznOksVjJzTmg3NKPNNaW985yWmtTmm9WCmMQ4rz+x5c5sUaZnTW4ekV8H5FmO
  XZlR+ft7frNfPZLd0Dzht4nv115CYfIWiid3xkChSZZGEmBpUtUa9SktvbyEeqUUeZmwlV/2runi
  fjFiOkEg9ErkkHhCtt1eSu/k2xC5lrl9vOuHd40kjTvLZQoqRSRiipCZhZIqQwV5klySdA6S5Uyx
  BG9++uLi9Tdk1H3z7O+35+QHeV444y/j0/Gcjqc8PwNZsnCz7tbH/FEIeMIUJKJyY+FITETpKbMU
  nao5l1A4nMw5XXBkOsnpM3oLFviPChz3X/8rz8DAwMDAwMDAwMDAwMDAwMDAwMDAwBDiX/8ITioA
  KAAA
EOF_fe583595f85998dbd4b0a698e89a15a91911fc3a

sed 's/^  //' <<\EOF_15da8006a8a6a7a3022639c048e1d1742f2b3f9c > etc/exists-lf.txt
  exists new line
  at end of file
EOF_15da8006a8a6a7a3022639c048e1d1742f2b3f9c

sed 's/^  //' <<\EOF_d4e1aebe6d7e4db0fc3c176f947a51b5e28a89ca | base64 -d > etc/no-lf.txt
  bm8gbmV3IGxpbmUKYXQgZW5kIG9mIGZpbGU=
EOF_d4e1aebe6d7e4db0fc3c176f947a51b5e28a89ca

sed 's/^  //' <<\EOF_d5a7faad42a2f6c86d0f3abb9712c7964f554b58 > main.sh
  cat $WORKING_DIR/etc/no-lf.txt
  cat $WORKING_DIR/etc/exists-lf.txt
  
  cd $WORKING_DIR
  find . | sort
  
EOF_d5a7faad42a2f6c86d0f3abb9712c7964f554b58

}
(
    cd $WORKING_DIR
    ichipack_generate_targets
)

####################################################################################################
cat $WORKING_DIR/etc/no-lf.txt
cat $WORKING_DIR/etc/exists-lf.txt

cd $WORKING_DIR
find . | sort

####################################################################################################
