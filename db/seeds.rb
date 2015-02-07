require 'open-uri'
require 'nokogiri'
require 'pry'

class ServiceSeeds

  attr_accessor :doc, :status_array, :description, :delay_header, :output_hash

  def initialize
    @output_hash = Hash.new {|hash, key| hash[key] = {}} 
    @doc = Nokogiri::XML(open("http://web.mta.info/status/serviceStatus.txt"))
  end

  def descriptive_status
    @doc.xpath('//subway//line').each do |line|

      train_name = line.at_css("/name").text

      train_status = line.at_css("status").text
      @output_hash[train_name][:status] = train_status 
      super_descriptive = line.xpath("text")

      html = Nokogiri::HTML(super_descriptive.text)

      if train_status == "GOOD SERVICE"
        super_descriptive = "On time"
      else  
        html.css(".plannedWorkDetailLink").each do |detail|
          planned_work = detail.children.text
          @output_hash[train_name][:header] = planned_work
        end

        html.css(".plannedWorkDetail").each do |detail|
          planned_work_detail = detail.children.text
          @output_hash[train_name][:details] = planned_work_detail
        end

        html.css(".TitleDelay").each do |detail| # working with this 
          title_delay = detail.children.text
          @output_hash[train_name][:title_delay] = title_delay
        end

        html.css(".TitleServiceChange").each do |detail|
          title_service_change = detail.children.first.text
          @output_hash[train_name][:service_change] = title_service_change
        end       
      end 
    end 
    @output_hash
  end
end

 service = ServiceSeeds.new

puts "deleting old Service seeds"
Service.destroy_all

service.descriptive_status.each do |train_name, info|

  Service.create(name: train_name, traffic: info[:status], description: info[:header], more_detail: info[:details], delay: info[:title_delay], change: info[:service_change])
end


puts "Updated service information"
