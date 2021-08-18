import { useModal } from "react-simple-modal-provider";

export default () => {
    const { open: openModal } = useModal("BasicModal");

    return <button onClick={openModal}>Open</button>;
};