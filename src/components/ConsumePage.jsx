import { useModal } from "react-simple-modal-provider";

export default ({ postTitle }) => {
    const { open } = useModal("BasicModal");
    return <button onClick={() => open({ title: "Hello World", body: "some body text", score: 69 })}> {postTitle} </button >;
};