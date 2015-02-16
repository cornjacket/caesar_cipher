require "spec_helper"

describe "caesar_cipher"  do
  it "does not encode numbers" do
  	expect(caesar_cipher("0123456789",1)).to eq "0123456789"
  end

  it "does not encode punctuation" do
  	expect(caesar_cipher(".,:;!?",1)).to eq ".,:;!?"
  end

  it "does not encode white space" do
  	expect(caesar_cipher(" ",1)).to eq " "
  end

  it "encodes alphabetic characters" do
    expect(caesar_cipher("Whatastring",5)).to eq "Bmfyfxywnsl"
  end

  it "decodes enocded characters by using a negative shift" do
    expect(caesar_cipher("Bmfyfxywnsl",-5)).to eq "Whatastring"
  end  

  it "encodes using a cyclic shift with a period of 26" do
    expect(caesar_cipher("Whatastring",5)).to eq caesar_cipher("Whatastring",5+26)
  end

  it "decodes using a cyclic shift with a period of 26" do
    expect(caesar_cipher("Whatastring",-5)).to eq caesar_cipher("Whatastring",-5+26)
  end
end