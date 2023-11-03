# Export binary path
export PATH=$PATH:/Users/totworasrivisal/Documents/hyperledger/bin

# Remove all existed artifacts
rm -rf ./channel/crypto-config
rm -rf ./channel/genesisBlock
rm ./channel/Org1MSPanchors.tx
rm ./channel/Org2MSPanchors.tx

# Generate defined crypto artifacts for Org
cryptogen generate --config=./crypto-config.yaml --output=./channel/crypto-config

# Define system channel
SYS_CHANNEL="system-channel"

# Define channel name to defaults to myChannel
CHANNEL_NAME="my-channel"

# Generate System Genesis block
configtxgen -profile OrdererGenesis -configPath . -channelID $SYS_CHANNEL  -outputBlock ./channel/genesisBlock/genesis.block

# Generate channel configuration block
configtxgen -profile MyChannel -configPath . -outputCreateChannelTx ./channel/mychannel.tx -channelID $CHANNEL_NAME

echo "#######    Generating anchor peer update for Org1MSP  ##########"
configtxgen -profile MyChannel -configPath . -outputAnchorPeersUpdate ./channel/Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org1

echo "#######    Generating anchor peer update for Org2MSP  ##########"
configtxgen -profile MyChannel -configPath . -outputAnchorPeersUpdate ./channel/Org2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org2