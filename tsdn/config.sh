echo ""
echo "config"
git clone https://github.com/trustnote/testnet-builder.git
cp -r ./testnet-builder/genesis-scripts/* ./tsdn/trustnote-headless/play/
node ./tsdn/trustnote-headless/play/create_allConfig.js --unsafe-perm
rm -rf ~/.config/headless15/trustnote*
cp -r ./testnet-builder/data/headless15/ ~/.config/
cat ./tsdn/data/config.json >> conf.txt
echo ""
echo "config finish"
