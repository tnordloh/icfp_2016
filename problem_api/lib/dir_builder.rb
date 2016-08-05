class DirBuilder
  def self.run(directory_name)
    Dir.entries(File.expand_path("../../../#{directory_name}/", __FILE__))
      .select  { |file| file.match(/\A[\w-]+\.txt\z/)}
      .map     { |file| file.gsub(/\.txt/, '') }
      .sort_by { |file| file.to_i }
  end
end
