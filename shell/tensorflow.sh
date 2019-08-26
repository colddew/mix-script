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

# over the GFW
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
# conda create --name tf2.0 python=3.7
# conda activate tf2.0

conda create --name tf1.14 python=2.7
conda init zsh
conda activate tf1.14
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

curl -LO https://github.com/tensorflow/tensorflow/raw/master/tensorflow/examples/label_image/label_image.py
python ~/tensorflow/example/label_image.py --graph=/tmp/output_graph.pb --labels=/tmp/output_labels.txt --input_layer=Placeholder --output_layer=final_result --image=$HOME/Downloads/pic_temp/1.jpg


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
