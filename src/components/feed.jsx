import React, { Component } from 'react';

class Feed extends Component {
    state = {
        postTitles: ['title1', 'title2', 'title3']
    }
    render() {
        return (
            <div>
                <h1> {this.getTitleString()} </h1>
                <ul>
                    {this.state.postTitles.map(post => <li key={post} onClick={() => this.expandPost(post)}>{post}</li>)}
                </ul>
            </div>);

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
    expandPost(title) {
        console.log(title);
    }
}

export default Feed;