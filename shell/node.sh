# create vue project
npm install -g vue-cli
vue init webpack vue-project
# vue init webpack-simple vue-simple-project
cd vue-project
npm install
npm run dev

# create webpack project
npm init
npm install -g webpack
npm install jsx-loader --save-dev
npm install style-loader --save-dev
npm install css-loader --save-dev
npm install url-loader --save-dev
npm install extract-text-webpack-plugin --save-dev
npm install webpack-dev-server --save-dev
npm install json-loader --save-dev

# webpack
wepack --display-error-details
wepack --config xxx.js
wepack -w
wepack -p
wepack -d
