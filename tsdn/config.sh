echo ""
echo "config"
git clone https://github.com/trustnote/testnet-builder.git
cp -r ./testnet-builder/genesis-scripts/* ./tsdn/trustnote-headless/play/
cd ./tsdn/trustnote-headless/play/
sudo node create_allConfig.js --unsafe-perm
cd ../../../
rm -rf ~/.config/headless15/trustnote*
cp -r ./tsdn/data/headless15/ ~/.config/
cat ./tsdn/data/config.json >> conf.txt
echo ""
echo "config finish"
