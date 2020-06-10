require 'minitest/autorun'
require 'net/http'

describe "Container started without MAGIC_HOST parameter" do

  describe "readiness probe" do
    READINESS_PATH = URI('http://127.0.0.1:3000/readiness')

    it "must respond with 400" do
      res = Net::HTTP.get_response(READINESS_PATH)
      assert_equal 400, res.code.to_i
    end
  end

end
