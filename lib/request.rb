require_relative "twitter_api.rb"
require 'geckoboard'
require 'dotenv'
require 'pry'
Dotenv.load

class Request
  attr_reader :client, :data
  attr_accessor :dataset

  def initialize(data)
    @client = Geckoboard.client(ENV["GECKO_KEY"])
    @data = data
  end

  def create_dataset
    @dataset = client.datasets.find_or_create("twitter.data", fields: [
      Geckoboard::NumberField.new(:followers, name: "Follower count"),
      Geckoboard::NumberField.new(:tweets, name: "Tweet count"),
      Geckoboard::NumberField.new(:rate, name: "Follower rate")
    ])
  end

  def update_dataset
    dataset.put(data.build_twitter_data)
  end

end
