require "rails_helper"

describe MovieExporterJob, :type => :job do
  describe "#perform_later" do
    it "export" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        MovieExporterJob.perform_later("export", "tmp/movies.csv")
      }.to have_enqueued_job
    end
  end
end