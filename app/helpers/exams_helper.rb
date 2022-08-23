require "set"
module ExamsHelper
  def random_list time, max
    randoms = Set.new
    loop do
      randoms << rand(max)
      break if randoms.length == time
    end
    randoms.to_a
  end
end
