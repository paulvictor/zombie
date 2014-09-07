require "sinatra/activerecord"
require 'open3'

#set :database, "sqlite3:patients.db"

class Patient < ActiveRecord::Base
  has_many :patient_temperatures
  TIME_FMT = "%d/%m-%H:%M"
  def img_file_name
    "/home/viktor/stuff/zombie/results/plot-#{name}-#{id}.png"
  end

  def csv_file_name
    "/home/viktor/stuff/zombie/results/plot-#{name}-#{id}.csv"
  end

  def plot_file
    pts = patient_temperatures
    gnuplot_commands = <<-END
     set terminal png
     set datafile separator " "
     set output "#{img_file_name}"
     set key off
     set xlabel "Minutes"
     set xtics 1,10
     set xrange [0:#{pts.size - 1}]
     set ylabel "Temperature"
     set title "Temperature variation over time for #{name}"
     plot "-" with lines
     SamplingTime Temperature
    END
    pts.each_with_index{|pt, i|
      #gnuplot_commands << Time.at(pt.sampling_time).strftime(TIME_FMT) + " " + pt.temperature.to_s + "\n"
      gnuplot_commands << i.to_s + " " + pt.temperature.to_s + "\n"
    }
    gnuplot_commands << "e\n"
    image, status = Open3.capture2("gnuplot", :stdin_data=>gnuplot_commands, :binmode=>true)
    img_file_name
  end

  def csv_file
    values = ([["Time", "Temperature"]] + patient_temperatures.map{|pt| [Time.at(pt.sampling_time), pt.temperature]}).map{|a| a.join(",")}
    File.open(csv_file_name, 'w') {|f| f.write(values.join("\n")) }
    csv_file_name
  end

  def self.latest_id
    Patient.last.id
  end
end

class PatientTemperature < ActiveRecord::Base
end
