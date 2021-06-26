#!/bin/bash
sed "s/tagVersion/$1/g" springBootMongo-PrivateRepo.yml > springbootmongopr.yml
