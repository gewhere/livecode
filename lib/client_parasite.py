"""
The script reads the data-pca.txt and replies to SC3
"""
import argparse
import numpy as np

from pythonosc import osc_message_builder
from pythonosc import udp_client

def read_pca_data(first, second):
    parser = argparse.ArgumentParser()
    parser.add_argument("--ip", default="127.0.0.1",
                        help="The ip of the OSC server")
    parser.add_argument("--port", type=int, default=7007,
                        help="The port the OSC server is listening on")
    args = parser.parse_args()
    client = udp_client.SimpleUDPClient(args.ip, args.port)
    return client.send_message("/components", str([first, second]))
