#!/bin/bash

rails db:create
rails db:migrate

rails s -b '0.0.0.0'
