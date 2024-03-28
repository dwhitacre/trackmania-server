import os

ROOT_PATH = os.path.dirname(os.path.dirname(__file__))
TMP_PATH = os.path.join(ROOT_PATH, 'tmp')
if not os.path.exists(TMP_PATH):
    os.mkdir(TMP_PATH)

DEBUG = bool(os.environ.get('PYPLANET_DEBUG', False))

POOLS = [
    'default'
]

OWNERS = {
    'default': [
        os.environ.get('TM_SERVER_OWNER', 'xxx')
    ]
}

SELF_UPGRADE = False

DATABASES = {
    'default': {
        'ENGINE': 'peewee_async.MySQLDatabase',
        'NAME': os.environ.get('MYSQL_DATABASE', 'pyplanet'),
        'OPTIONS': {
            'host': os.environ.get('MYSQL_HOST', 'database'),
            'port': int(os.environ.get('MYSQL_PORT', '25060')),
            'user': os.environ.get('MYSQL_USER', 'pyplanet'),
            'password': os.environ.get('MYSQL_PASSWORD', ''),
            'charset': 'utf8mb4',
        }
    }
}

DEDICATED = {
    'default': {
        'HOST': os.environ.get('TM_HOST', 'trackmania'),
        'PORT': '5000',
        'USER': 'SuperAdmin',
        'PASSWORD': 'SuperAdmin',
    }
}

MAP_MATCHSETTINGS = {
    'default': 'maplist.txt',
}

# BLACKLIST_FILE = {
#     'default': 'blacklist.txt'
# }

# GUESTLIST_FILE = {
#   'default': 'guestlist.txt',
# }

STORAGE = {
    'default': {
        'DRIVER': 'pyplanet.core.storage.drivers.local.LocalDriver',
        'OPTIONS': {
            'BASE_PATH': '/app/server'
        },
    }
}

SONGS = {
    'default': []
}
