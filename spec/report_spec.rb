module TermiChunk
  describe Report do
    let(:subject) { described_class.new(title: 'Some Report') }
    let(:result) { subject.to_s + "\n" }

    it 'can make a narrow report' do
      subject << 'Line 1'
      subject << 'Line 2'
      expect(result).to eq <<~EOF
        ┌─[ Some Report ]──
        │ Line 1
        │ Line 2
        └─[ Some Report ]──
      EOF
    end

    it 'can make a wide report' do
      subject << 'Line 1 has a whole lot of stuff in it'
      subject << 'Line 2 has a pretty good amount, too'
      expect(result).to eq <<~EOF
        ┌─[ Some Report ]────────────────────────
        │ Line 1 has a whole lot of stuff in it
        │ Line 2 has a pretty good amount, too
        └─[ Some Report ]────────────────────────
      EOF
    end

    it 'can make a report that has a report' do
      subject << "Line 1a\nLine 1b\n"
      subject << described_class.new(title: 'Sub-report') { |r| r << "Whoa!\nThis is down in there" }
      expect(result).to eq <<~EOF
        ┌─[ Some Report ]─────────────
        │ Line 1a
        │ Line 1b
        │ ┌─[ Sub-report ]─────────
        │ │ Whoa!
        │ │ This is down in there
        │ └─[ Sub-report ]─────────
        └─[ Some Report ]─────────────
      EOF
    end

    it 'can make an empty report' do
      expect(result).to eq <<~EOF
        ┌─[ Some Report ]──
        └─[ Some Report ]──
      EOF
    end

    context 'padding' do
      let(:contents) { "Line 1 has some stuff in it\nLine 2 has less" }
      let(:subject) { described_class.new(title: 'Some Report', padding: padding) { |r| r << contents } }

      context '1' do
        let(:padding) { 1 }

        it 'can make a report with some padding' do
          expect(result).to eq <<~EOF
            ┌─[ Some Report ]─────────────────
            │
            │  Line 1 has some stuff in it
            │  Line 2 has less
            │
            └─[ Some Report ]─────────────────
          EOF
        end

        it 'will vertically pad around a sub-report' do
          subject << described_class.new(title: 'Sub-report', padding: 2) { |r| r << "Whoa!\nThis is down in there" }
          subject << 'Yeah'
          expect(result).to eq <<~EOF
            ┌─[ Some Report ]───────────────────
            │
            │  Line 1 has some stuff in it
            │  Line 2 has less
            │  
            │  ┌─[ Sub-report ]─────────────
            │  │
            │  │
            │  │   Whoa!
            │  │   This is down in there
            │  │
            │  │
            │  └─[ Sub-report ]─────────────
            │  
            │  Yeah
            │
            └─[ Some Report ]───────────────────
          EOF
        end

        context 'empty' do
          let(:subject) { described_class.new(title: 'Some Report', padding: padding) }

          it 'can make an empty report' do
            expect(result).to eq <<~EOF
              ┌─[ Some Report ]────
              │
              └─[ Some Report ]────
            EOF
          end
        end
      end

      context '3' do
        let(:padding) { 3 }

        it 'can make a report with some padding' do
          expect(result).to eq <<~EOF
            ┌─[ Some Report ]─────────────────────
            │
            │
            │
            │    Line 1 has some stuff in it
            │    Line 2 has less
            │
            │
            │
            └─[ Some Report ]─────────────────────
          EOF
        end

        context 'empty' do
          let(:subject) { described_class.new(title: 'Some Report', padding: padding) }

          it 'can make an empty report' do
            expect(result).to eq <<~EOF
              ┌─[ Some Report ]────────
              │
              │
              │
              └─[ Some Report ]────────
            EOF
          end
        end
      end
    end
  end
end
