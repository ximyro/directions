# Directions Calculator

## Requirements

- mongoid
- ruby >= 2.4.1

## Microservices in subfolders

 - coster
 - directions

## Setup

### Setup Coster Service
 - cd coster
 - bundle install
 - cp config.yml.example config.yml
 - cp mongoid.yml.exampl mongoid.yml

### Setup Direction Service
- cd directions
- bundle install

## Run

Run `foreman start` in root folder
