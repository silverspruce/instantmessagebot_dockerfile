# 用于获取国务院实时消息

# 使用python3版本
FROM python:3

# 修改时区 改为中国时区 CST Asia/Shanghai
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 更换pip源为国内清华源
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# 安装html解析器bs4 http客户端 requests   aiohttp是第三方http客户端 aiosocksy是辅助aiohttp使用socks代理
RUN pip install beautifulsoup4 requests requests[socks] aiohttp aiosocksy
RUN pip install apscheduler
RUN pip install lxml
# 设置匿名卷
VOLUME /datavolume

# 设置工作目录
WORKDIR /datavolume

# 复制python源文件到工作目录
#COPY deploy.py ./

# 运行服务器
ENTRYPOINT ["python","./deploy.py"]
