import Modal, { useModalState } from "react-simple-modal-provider";

export default ({ children }) => {
    const [isOpen, setOpen] = useModalState();

    return (
        <Modal
            id={"BasicModal"}
            consumer={children}
            isOpen={isOpen}
            setOpen={setOpen}
        >
            <span>😆</span>
        </Modal>
    );
};