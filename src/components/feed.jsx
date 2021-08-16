import React, { Component } from 'react';
import Post from './post';
import { ModalProvider } from "react-simple-modal-provider";
import Modal from './modal';
class Feed extends Component {
    state = {
        posts: [{ id: 0, title: "post 1", content: "this is post 2", score: "100" }, { id: 1, title: "post 2", content: "this is post 2", score: "101" }, { id: 2, title: "post 3", content: "this is post 3", score: "102" }]
    }
    render() {
        return (
            <React.Fragment>

                <div>
                    <h1> {this.getTitleString()} </h1>
                    <ul>
                        {this.state.posts.map(post => <Post content={post}></Post>)}
                    </ul>
                </div>

            </React.Fragment>
        );

    }
    getTitleString() {
        const d = new Date();
        const months = ["January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"];
        var titleString = months[d.getMonth()] + " ";
        titleString += d.getDate();
        titleString += ", ";
        titleString += d.getFullYear();

        return titleString;
    }

}

export default Feed;