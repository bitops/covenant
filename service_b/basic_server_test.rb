require 'minitest/autorun'
require 'net/http'

describe "Basic Pod-ready containerized web process" do

  ROOT_PATH = URI('http://127.0.0.1:3000/')

  describe "main application" do
    describe "GET /" do
      it "works" do
        res = Net::HTTP.get_response(ROOT_PATH)
        assert_equal 200, res.code.to_i
      end

      it "returns json" do
        res = Net::HTTP.get_response(ROOT_PATH)
        assert_equal "application/json", res.header["Content-Type"]
      end

      it "returns data" do
        res = Net::HTTP.get_response(ROOT_PATH)
        assert_equal "{}", res.body
      end
    end

    describe "GET /magic" do
      MAGIC_PATH = URI('http://127.0.0.1:3000/magic')

      it "works" do
        res = Net::HTTP.get_response(MAGIC_PATH)
        assert_equal 200, res.code.to_i
        assert_equal "application/json", res.header["Content-Type"]
        assert_equal '{"data":{"main":{"answer":"42"}}}', res.body
      end
    end
  end

  describe "routing" do
    describe "allowed routes" do
      it "allows /" do
        res = Net::HTTP.get_response(ROOT_PATH)
        assert_equal 200, res.code.to_i
      end

      it "disallows anything else" do
        assert_equal 404, Net::HTTP.get_response(URI('http://127.0.0.1:3000/foo')).code.to_i
        assert_equal 404, Net::HTTP.get_response(URI('http://127.0.0.1:3000/bar')).code.to_i
        assert_equal 404, Net::HTTP.get_response(URI('http://127.0.0.1:3000/baz')).code.to_i
      end
    end
  end

  describe "readiness probe" do
    READINESS_PATH = URI('http://127.0.0.1:3000/readiness')

    it "must respond with 200" do
      res = Net::HTTP.get_response(READINESS_PATH)
      assert_equal 200, res.code.to_i
    end
  end

  describe "liveness probe" do
    LIVENESS_PATH = URI('http://127.0.0.1:3000/liveness')

    it "must respond with 200" do
      res = Net::HTTP.get_response(LIVENESS_PATH)
      assert_equal 200, res.code.to_i
    end
  end

end
