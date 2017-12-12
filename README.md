# Directions Calculator

## Requirements

- mongoid
- ruby >= 2.4.1

## Microservices in subfolders

 - coster
 - directions

## Setup

### Setup Coster Service
 - `cd coster`
 - `bundle install`
 - `cp config.yml.example config.yml`
 - `cp mongoid.yml.exampl mongoid.yml`

### Setup Direction Service
- `cd directions`
- `bundle install`

## Run

Run `foreman start` in root folder

## Technologies

- mongoid - Удобная, быстрая база дынных для хренения промежуточных данных
- grape - В данном случае нет необходимости использовать громоздкий Rails. Grape удобнее для документирования, разделения логики, управления параметрами и т.д.
- active_model_serializers - Удобный модуль для управления рендером json
- oj - Быстрее чем стандартный json adapter
