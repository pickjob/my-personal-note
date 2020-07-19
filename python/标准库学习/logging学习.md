# logging学习
```python
import logging
import logging.config
# simple
FORMAT = '%(asctime)s [%(levelname)s] %(filename)s-%(funcName)s: %(message)s'
logging.basicConfig(filename='logs/app.log', format=FORMAT, level=logging.INFO)
logger = logging.getLogger('main')
logger.info('hello world')
# config file
logging.config.fileConfig('conf/logging.conf')
logger = logging.getLogger('main')
logger.info('hello world')
```