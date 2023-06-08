#!/bin/sh
sudo systemctl start rabbitmq-server
sudo systemctl start f1sim-producer
sudo systemctl start f1sim-consumer

