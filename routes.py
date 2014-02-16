import os
from flask import Flask, jsonify
from flask import request
import braintree

import pdb

app = Flask(__name__)

braintree.Configuration.configure(
    braintree.Environment.Sandbox,
    "xnzh6ck7y63v2b2h",
    "m8qxc76gv9f6jjww",
    "21f6926edeb68c5f8ec8e0294cbdf450"
)

@app.route('/')
def index():
    pdb.set_trace()
    return 'Foo'

@app.route('/card', methods=["POST"])
def card():
    print "HITTING /card"
    result = braintree.Transaction.sale({
            "amount": "10.00",
            "credit_card": {
                "number":  request.headers["Card-Number"],
                "expiration_month": request.headers["Expiration-Month"],
                "expiration_year": request.headers["Expiration-Year"]
            },
            "options": {
                "venmo_sdk_session": request.headers["Venmo-Sdk-Session"]
            }
        })

    if result.is_success:
        print "success!: " + result.transaction.id
        return jsonify( {"success": 1} )
    elif result.transaction:
        print "Error processing transaction:"
        print "  message: " + result.message
        print "  code:    " + result.transaction.processor_response_code
        print "  text:    " + result.transaction.processor_response_text
    else:
        print "message: " + result.message
        for error in result.errors.deep_errors:
            print "attribute: " + error.attribute
            print "  code: " + error.code
            print "  message: " + error.message

    return jsonify( {"success": 0} )
    # return flask.jsonify(**{success: 1})


@app.route('/touch', methods=["POST"])
def touch():
    pdb.set_trace()
    result = braintree.Transaction.sale({
        "amount": "10.00",
        "venmo_sdk_payment_method_code": params["venmo_sdk_payment_method_code"]
    })

    if result.is_success:
        print "success!: " + result.transaction.id
        return jsonify( {"success": 1} )
    elif result.transaction:
        print "Error processing transaction:"
        print "  message: " + result.message
        print "  code:    " + result.transaction.processor_response_code
        print "  text:    " + result.transaction.processor_response_text
    else:
        print "message: " + result.message
        for error in result.errors.deep_errors:
            print "attribute: " + error.attribute
            print "  code: " + error.code
            print "  message: " + error.message

    return jsonify( {"success": 0} )

if __name__ == '__main__':
    app.run()
