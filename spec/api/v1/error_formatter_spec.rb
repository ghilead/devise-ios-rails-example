module V1
  describe ErrorFormatter do
    subject { JSON.parse described_class.call(error, double, double, double) }
    let(:error) { 'some error' }

    it 'has error root' do
      expect(subject).to include('error')
    end

    context 'error is plain message' do
      it 'converts an error to json' do
        expect(subject).to eq(
          'error' => {
            message: 'some error',
            code: 0,
            status: 500,
          }.stringify_keys
        )
      end
    end

    context 'error is an error object' do
      let(:error) { create(:error, message: 'Evil doings!', code: 666, status: 500) }

      it 'converts an error to a rich json' do
        expect(subject).to eq(
          'error' => {
            message: 'Evil doings!',
            code: 666,
            status: 500,
          }.stringify_keys
        )
      end
    end
  end
end
