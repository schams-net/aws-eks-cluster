{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "rds-db:connect"
            ],
            "Resource": [
                "arn:aws:rds-db:${region}:${account}:dbuser:${resource}/${username}"
            ]
        }
    ]
}
