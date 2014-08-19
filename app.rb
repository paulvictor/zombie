require "sinatra"
require_relative "models"

configure do
  # logging is enabled by default in classic style applications,
  # so `enable :logging` is not needed
  file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
  file.sync = true
  use Rack::CommonLogger, file
end

before do
  logger.level = 0
end

before do
  @started = File.exist?("/home/viktor/stuff/zombie/started")
end

get '/' do
  @action_to_perform = (@started ? "Stop" : "Start") + " Recording"
  @patients = Patient.all
  erb :"patients/index"
end

get '/patients/new' do
  @patient = Patient.new
  erb :"patients/new"
end

get '/patients/:id/plot' do
  @patient = Patient.where(id: params[:id]).last
  if @patient
    if @patient.patient_temperatures.empty?
      "No temperatures recorded for #{@patient.name}"
    else
      file_name = @patient.plot_file
      response.headers['Content-Disposition'] = "attachment; filename=\"#{file_name}\""
      send_file file_name, :type => :png
    end
  else
    "Patient not found"
  end
end

get '/patients/:id/values' do
  @patient = Patient.where(id: params[:id]).last
  if @patient
    if @patient.patient_temperatures.empty?
      "No temperatures recorded for #{@patient.name}"
    else
      file_name = @patient.csv_file
      response.headers['Content-Disposition'] = "attachment; filename=\"#{file_name}\""
      send_file file_name, :type => :csv
    end
  else
    "Patient not found"
  end
end

post '/patients' do
  @patient = Patient.new(params[:patient])
  @patient.save
  redirect "/"
end

post '/patient_temperatures' do
  @patient_temperature = PatientTemperature.new(params[:patient_temperature].merge(patient_id: Patient.latest_id))
  @patient_temperature.save
  redirect "/"
end

post '/stop_or_start' do
  if File.exists?("/home/viktor/stuff/zombie/started")
    FileUtils.rm(["/home/viktor/stuff/zombie/started"])
  else
    FileUtils.touch(["/home/viktor/stuff/zombie/started"])
  end
  redirect "/"
end
