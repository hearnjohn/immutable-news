import logo from './logo.svg';
import './App.css';
import { ModalProvider } from 'react-simple-modal-provider';
import Feed from './components/feed';
import BasicModal from './components/BasicModal';
import ConsumePage from './components/ConsumePage';

function App() {
  return (
    <ModalProvider value={[BasicModal]}>
      <Feed />
      <ConsumePage />
    </ModalProvider>
  );
}

export default App;
