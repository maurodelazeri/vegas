#!/bin/sh

while true
do

    f=$(uuidgen)

    openssl rand 32 > $f.bin
    hex=$(hexdump -e '32/1 "%02X" "\n"' $f.bin)

    wif=$(/Users/maurodelazeri/Downloads/bitcoin-tool/bitcoin-tool --network bitcoin --input-type private-key --input-format raw --input-file $f.bin --output-type private-key-wif --output-format base58check --public-key-compression uncompressed)

    wif_compressed=$(/Users/maurodelazeri/Downloads/bitcoin-tool/bitcoin-tool --network bitcoin --input-type private-key --input-format raw --input-file $f.bin --output-type private-key-wif  --output-format base58check  --public-key-compression compressed)

    public=$(/Users/maurodelazeri/Downloads/bitcoin-tool/bitcoin-tool --input-type private-key-wif --input-format base58check --input $wif --output-type address --output-format base58check)

    public_compressed=$(/Users/maurodelazeri/Downloads/bitcoin-tool/bitcoin-tool --input-type private-key-wif --input-format base58check --input $wif_compressed --output-type address --output-format base58check)

    rm $f.bin

    #CSV
    echo "$public;$wif;$public_compressed;$wif_compressed"
done
