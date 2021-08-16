import React, { Component } from 'react';
class Post extends Component {
    state = { id: this.props.content.id, title: this.props.content.title, content: this.props.content.content, score: this.props.content.score }
    render() {

        return (<li key={this.state.content.id} onClick={() => this.expandPost()}>
            <span>
                <button onClick={() => this.changeScore(true)}>+</button>
                {this.state.title + " " + this.state.score}
                <button onClick={() => this.changeScore(false)}>-</button>
            </span>
        </li>);
    }
    expandPost() {
        console.log(this.state.id);
    }
    changeScore(positive) {
        if (positive) {
            this.setState({ score: parseInt(this.state.score) + 1 })
        } else {
            this.setState({ score: parseInt(this.state.score) - 1 })
        }
    }
}

export default Post;