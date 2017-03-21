require 'fileutils'

from = ARGV[0]
to = ARGV[1]

# Set desired destination size in gigabytes
desiredDestinationSize = 50

# Calculates bytes from gigabytes
destinationMaxCapactiy = desiredDestinationSize * 1073741824

def directory_size(path)
  path << '/' unless path.end_with?('/')
  raise RuntimeError, "#{path} is not a directory" unless File.directory?(path)
  total_size = 0
  Dir["#{path}*"].each do |f|
    total_size += File.size(f) if File.file?(f) && File.size?(f)
  end
  total_size
end

if from && to
	puts "## Backing up videos from #{from} to #{to}"
	puts "## Figuring out which files need copying"
		filesToCopy = Array.new
		Dir["#{from}*.MP4"].each do |f|
			filename = File.basename(f)
			path = "#{to}#{filename}"
		    if !File.file? path
		    	puts "#{filename} needs copying"
		    	filesToCopy.unshift(f)
		    end
		end
		if filesToCopy.empty?
			puts "## Nothing to do"
			abort
		end
		toDirectorySize = directory_size to
		totalSizeOfFilesToCopy = 0
		filesToCopy.each do |f|
			totalSizeOfFilesToCopy += File.size(f) if File.file?(f) && File.size?(f)
		end
	puts "## Seeing if there is enough space in the source directory"
		newSizeAfterCopy = toDirectorySize + totalSizeOfFilesToCopy
		dif = 0
		if newSizeAfterCopy < destinationMaxCapactiy
			puts "There is enough space for the new files"
		else
			puts "We need to make space for new files"
			dif = newSizeAfterCopy - destinationMaxCapactiy
			puts "## Deleting oldest files until there is enough space"
			targetSize = destinationMaxCapactiy - dif
			while toDirectorySize > targetSize
				oldestFile = Dir.glob("#{to}*").min_by {|f| File.birthtime(f)}
				toDirectorySize -= File.size(oldestFile) if File.file?(oldestFile) && File.size?(oldestFile)
				oldFileName = File.basename(oldestFile)
				puts "Deleting #{oldFileName}"
				File.delete(oldestFile)
			end
		end
	puts "## Copying new files to source directory"
		filesToCopy.each do |f|
			filename = File.basename(f)
			destination = "#{to}#{filename}"
			puts "Copying #{filename}"
            FileUtils.cp f, destination, :preserve => true
		end
	puts "## DONE"
else
	fail ArgumentError, "Please supply to and from paths usage: 'ruby brap.rb /from/path/ /to/path/'"
end
