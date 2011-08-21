load './share-dotfile'
require 'pathname'
require 'fileutils'

def dotfile(name, content = nil)
  path = home + name
  path.open("w") {|f| f.write(content || path) }
end

describe "Sharing dotfiles" do
  let(:tmp) { Pathname("/tmp/spectmp") }
  let(:home) { tmp + "home" }
  let(:shared) { tmp + "shared" }

  before do
    FileUtils.rm_rf tmp
    FileUtils.mkdir_p home
    FileUtils.mkdir_p shared

    Dotfile.configure(:home => home, :shared => shared)
  end

  describe Dotfile do
    subject { Dotfile.new(".foo") }

    context "#share" do
      context "for a nonexistent dotfile" do
        it "raises an error" do
          expect { subject.share }.to raise_error /\.foo.* does not exist/
        end
      end

      context "for an existing dotfile" do
        before { dotfile(".foo", "Original Foo") }
        let(:dest) { shared + "foo" }

        before { subject.share }

        it "moves a dotfile to the shared location" do
          dest.should exist
          dest.read.should == "Original Foo"
        end

        it "links the original name to the moved file" do
          (home + ".foo").readlink.should == dest
        end

        it "raises if the file was already shared" do
          expect { subject.share }.to raise_error /\.foo.* already shared as .*shared\/foo/
        end
      end
    end
  end

  describe DotfileSharer do
    subject { DotfileSharer.new }

    context "#run" do
      before { dotfile(".foo", "Original Foo") }
      let(:dest) { shared + "foo" }

      it "shares the first argument" do
        subject.run([".foo"])

        (home + ".foo").readlink.should == dest
      end

    end
  end
end
