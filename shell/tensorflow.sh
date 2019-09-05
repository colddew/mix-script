# install tensorflow from conda
# config conda mirror
conda config --show-sources
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --set show_channel_urls yes
conda config --remove channels 'https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/'

conda create --name [env-name]
conda activate [env-name]
conda deactivate
conda env remove --name [env-name]
conda env list

# config pip mirror
pip install pip -U
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
# pip install -i https://pypi.tuna.tsinghua.edu.cn/simple some-package
# pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U

pip install [package-name]
pip install [package-name]==X.X
pip install [package-name] --proxy=<proxy-ip>:<proxy-port>
pip install [package-name] --upgrade
pip uninstall [package-name]
pip list

# fly over the GFW
brew install privoxy
vi /usr/local/etc/privoxy/config
# listen-address 0.0.0.0:8118
# forward-socks5 / localhost:1080 .
sudo /usr/local/sbin/privoxy /usr/local/etc/privoxy/config
netstat -na | grep 8118
export http_proxy='http://localhost:8118'
export https_proxy='http://localhost:8118'
# curl ip.gs
unset http_proxy
unset https_proxy

# install tensorflow & tensorflow-hub
# conda create --name tf1.14 python=2.7
# conda activate tf1.14

conda create --name tf2.0 python=3.7
conda init zsh
conda activate tf2.0
conda deactivate

pip install tensorflow
pip install tensorflow-hub

# example
python
import tensorflow as tf
A = tf.constant([[1, 2], [3, 4]])
B = tf.constant([[5, 6], [7, 8]])
C = tf.matmul(A, B)
print(C)

# retrain and test categories
curl -O http://download.tensorflow.org/example_images/flower_photos.tgz
tensorboard --logdir /tmp/retrain_logs
curl -LO https://github.com/tensorflow/hub/raw/master/examples/image_retraining/retrain.py

python ~/tensorflow/example/retrain.py --image_dir ~/tensorflow/flower_photos
python ~/tensorflow/example/retrain.py --image_dir ~/Downloads/pic/succulent-train-new --print_misclassified_test_images --saved_model_dir=/tmp/saved_models/$(date +%s)
# python ~/tensorflow/example/retrain.py --image_dir ~/Downloads/pic/succulent-train-new --print_misclassified_test_images
# python ~/tensorflow/example/retrain.py --image_dir ~/tensorflow/flower_photos --random_crop 5 --random_scale 5 --random_brightness 5

curl -LO https://github.com/tensorflow/tensorflow/raw/master/tensorflow/examples/label_image/label_image.py
python ~/tensorflow/example/label_image.py \
--graph=/tmp/output_graph.pb \
--labels=/tmp/output_labels.txt \
--input_layer=Placeholder \
--output_layer=final_result \
--image=$HOME/Downloads/pic_temp/555.jpg


# install tensorflow from docker
docker pull tensorflow/tensorflow
# docker run [-it] [--rm] [-p hostPort:containerPort] tensorflow/tensorflow[:tag] [command]
docker run -it -p 8888:8888 tensorflow/tensorflow
# verify the TensorFlow installation using the latest tagged image
# docker run -it --rm tensorflow/tensorflow python -c "import tensorflow as tf; tf.enable_eager_execution(); print(tf.reduce_sum(tf.random_normal([1000, 1000])))"
# docker run -it --rm tensorflow/tensorflow python -c "import tensorflow as tf; A = tf.constant([[1, 2], [3, 4]]); B = tf.constant([[5, 6], [7, 8]]); C = tf.matmul(A, B); print(C)"
docker run -it --rm tensorflow/tensorflow python -c "import tensorflow as tf; print tf.__version__"
# Start a bash shell session within a TensorFlow-configured container
docker run -it tensorflow/tensorflow bash
# To run a TensorFlow program developed on the host machine within a container, mount the host directory and change the container's working directory
docker run -it --rm -v $PWD:/tmp -w /tmp tensorflow/tensorflow python <command>.py


# install tensorflow serving with docker
docker run -t --rm -p 8501:8501 \
-v /tmp:/models \
-e MODEL_NAME=saved_models \
tensorflow/serving &

# docker run -t --rm -p 8501:8501 \
# --mount type=bind,source=/tmp/saved_models,target=/models/saved_models \
# -e MODEL_NAME=saved_models \
# tensorflow/serving &

# the same to run in the container
# tensorflow_model_server --port=8500 --rest_api_port=8501 --model_name=${MODEL_NAME} --model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME}
# MODEL_NAME (defaults to model)
# MODEL_BASE_PATH (defaults to /models)

# invoke tensorflow serving api
# http://127.0.0.1:8500
# GET http://host:port/v1/models/${MODEL_NAME}[/versions/${MODEL_VERSION}]
# GET http://host:port/v1/models/${MODEL_NAME}[/versions/${MODEL_VERSION}]/metadata
# POST http://host:port/v1/models/${MODEL_NAME}[/versions/${MODEL_VERSION}]:(classify|regress)
# POST http://host:port/v1/models/${MODEL_NAME}[/versions/${MODEL_VERSION}]:predict
curl http://localhost:8501/v1/models/saved_models
curl http://localhost:8501/v1/models/saved_models/metadata

# download inception_v3 model
# https://tfhub.dev/google/imagenet/inception_v3/feature_vector/3
# replace 'https://tfhub.dev' with 'https://storage.googleapis.com/tfhub-modules' and add '.tar.gz' at the end of url
# https://storage.googleapis.com/tfhub-modules/google/imagenet/inception_v3/feature_vector/3.tar.gz

# clean temp workdir
# pkill -f "tensorboard"
rm _retrain_checkpoint*
rm checkpoint
rm output_graph.pb
rm output_labels.txt
rm -rf bottleneck
rm -rf retrain_logs
rm -rf saved_models
