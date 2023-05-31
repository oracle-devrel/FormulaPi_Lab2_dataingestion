import oracledb
import sys
import os
import logging
from pathlib import Path
from f1sim import PacketWriter

home = str(Path.home())

class OracleDatabaseConnection(PacketWriter):
    def __init__(self, parameters):
        self.dbusername = parameters['dbusername']
        self.dbpassword = parameters['dbpassword']
        self.poolsize = parameters['poolsize']
        self.dburl = parameters['dburl']
        self.dbwalletdir = parameters['dbwalletdir']
        self.dbwalletpassword = parameters['dbwalletpassword']
        logging.debug(self.dburl)
        logging.debug(self.dbusername)
        logging.debug(self.dbpassword)
        logging.debug(self.poolsize)
        logging.info("Sending to " + self.dbusername+"@"+self.dburl);
        self.pool = oracledb.create_pool(user=self.dbusername, password=self.dbpassword, dsn=self.dburl, min=self.poolsize, max=self.poolsize, increment=1, threaded=True, config_dir=self.dbwalletdir, wallet_location=self.dbwalletdir, wallet_password=self.dbwalletpassword)
        self.pool.ping_interval = 120
        self.pool.timeout = 600
        logging.info('Connection successful.')

    def close_pool(self):
        self.pool.close()
        logging.info('Connection pool closed.')

    def insert(self, location, parameters):
        connection = None
        retry = 3
        while retry > 0:
            try:
                connection = self.pool.acquire()
                connection.autocommit = True
                cursor = oracledb.Cursor(connection)
                cursor.execute(location,parameters);
                return 1
            except Exception as ex:
                logging.error(ex)
                retry = retry - 1
            finally:
                if connection != None:
                    self.pool.release(connection)
            logging.error("retries failed")

def test_class():
    parameters = { "dbusername" : "username", "dbpassword" : "password", "dburl" : "url" };
    object = OracleDatabaseConnection(parameters)
    logging.info(object.pool)
    object.close_pool()

if __name__ == '__main__':
    test_class()
