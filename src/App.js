import logo from './logo.svg';
import './App.css';
import { ModalProvider } from 'react-simple-modal-provider';
import Feed from './components/feed';
import BasicModal from './components/BasicModal';


function App() {
  return (
    <ModalProvider value={[BasicModal]}>
      <Feed />
    </ModalProvider>
  );
}

export default App;
