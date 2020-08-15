# frozen_string_literal: true
module TermiChunk
  class Report
    X = '─'
    Y = '│'
    TL = '┌'
    BL = '└'

    attr_reader :title, :padding, :rows

    # Create a new report.
    # @param title [String] the title to frame the report with
    # @param padding [Integer] the amount of padding to put around the text within the report
    # @yield [self] if a block is provided, the new report will be yielded to it
    # @return [Report]
    def initialize(title:, padding: nil)
      @title = title
      @padding = padding || 0
      @rows = []
      yield self if block_given?
    end

    # Add a new entry to the report
    # @param item [String, Report] the entry to add (a single-line string, a multi-line string, a sub-report)
    def <<(item)
      lines = item.to_s.lines
      if item.is_a?(self.class) && padding.nonzero?
        buffer = padding.times.map { "\n" }
        lines = [*buffer, *lines, *buffer]
      end
      lines.each { |l| rows << l }
    end

    # Retrieve a string-representation of the report.
    # @return [String]
    def to_s
      y = padding.times.map { Y }
      [titlebar(TL), *y, body, *y, titlebar(BL)].compact.join("\n")
    end

    private

    def body
      rows.map { |l| "#{Y} #{' ' * padding}#{l.chomp}" }.join("\n")
    end

    def titlebar(corner)
      heading = "#{corner}#{X}[ #{title} ]"
      heading += (X * (width + 2 + (padding * 2) - heading.length))
      heading
    end

    def width
      [rows.map(&:length).max + 2, title.length + 6].max
    end
  end
end
