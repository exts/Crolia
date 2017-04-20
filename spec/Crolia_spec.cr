require "./spec_helper"

describe Crolia do
  describe ".ENDPOINT_URL" do
    it "should match expected end point url" do
      Crolia::ENDPOINT_URL.should eq "https://[APPID][DSN].algolia.net/"
    end
  end

  describe "#parse_url" do
    it "should parse api end point url" do
      matched = "https://12345.algolia.net/1/indexes/*/queries"
      Crolia.parse_url("/1/indexes/*/queries/", "12345").should eq matched
    end

    it "should parse api end point url with dsn" do
      matched = "https://12345-dsn.algolia.net/1/indexes/*/queries"
      Crolia.parse_url("/1/indexes/*/queries/", "12345", true).should eq matched
    end
  end

  describe "#api_path" do
    it "should raise invalid api path error" do
      expect_raises(Crolia::Exceptions::InvalidApiPath) do
        Crolia.api_path("invalid")  
      end
    end

    it "should return valid path" do
      matched = "/1/indexes"
      Crolia.api_path("index/list").should eq matched
    end

    it "should return valid path with optional replacement values" do
      matched = "/1/indexes/example"
      Crolia.api_path("index/search", {"index" => "example"}).should eq matched
    end
  end
end
