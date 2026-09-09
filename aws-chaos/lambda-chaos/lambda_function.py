import json
import time
import os

def lambda_handler(event, context):

    action = event.get("action", "normal")

    if action == "sleep":
        time.sleep(5)

    elif action == "error":
        raise Exception("Chaos induced application error")

    elif action == "memory":
        data = ["chaos-data" * 1000 for _ in range(1000)]

    elif action == "memory_stress":
        data = ["X" * 1024 * 1024 for _ in range(200)]

    elif action == "config_test":
        app_mode = os.environ.get("APP_MODE")

        if app_mode != "production":
            raise Exception(
                f"Configuration error: invalid APP_MODE={app_mode}"
            )

    elif action == "dependency_failure":
        raise Exception("Chaos induced downstream dependency failure")
    
    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Lambda executed successfully",
            "action": action
        })
    }
