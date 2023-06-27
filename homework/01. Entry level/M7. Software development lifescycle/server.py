from flask import Flask, request, jsonify
import requests
import os
import sys


# create flask object
app = Flask(__name__)
cli = sys.modules['flask.cli']


#  ping-scan range of ip addresses function
def ping_sweep(network, count):
    active_hosts = {}
    ip_parts = network.split(".")
    network_ip = ip_parts[0] + "." + ip_parts[1] + "." + ip_parts[2] + "."

    #  check all ip addresses in range and send ping-requests
    for i in range(0, count + 1):
        scanned_ip = network_ip + str(int(ip_parts[3]) + i)
        response = os.popen(f"ping -n 1 {scanned_ip}")
        #  response = os.popen(f"ping -c 1 {scanned_ip}") for linux
        res = response.readlines()
        active_hosts[scanned_ip] = res[2]
        print(f"[#] Result of scanning: {scanned_ip} [#]\n{res[2]}", end="\n")
    return active_hosts


#  decorator for work with HTTP request sendhttp
@app.route("/sendhttp", methods=["POST"])
def send_http_request():
    request_data = request.get_json()  # get data from API
    headers = request.headers  # get headers from API
    method = request_data["method"]  # method from main.py
    target = request_data["target"]  # target url from main.py
    payload = request_data.get("payload", None)

    #  send HTTP request to url
    response = requests.request(method, target, headers=headers, data=payload)
    return response.content, response.status_code


#  scan decorator for work with HTTP request scan
@app.route("/scan", methods=["GET"])
def scan_network():
    request_data = request.get_json()
    target = request_data["target"]
    count = int(request_data["count"])
    active_hosts = ping_sweep(target, count)
    return jsonify(active_hosts)


#  starting flask app @ host & port
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3000)