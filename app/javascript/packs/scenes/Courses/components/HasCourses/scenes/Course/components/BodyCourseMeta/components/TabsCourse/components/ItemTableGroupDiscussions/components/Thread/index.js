import React, { Component } from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';
import IconPlus from 'react-icons/lib/fa/plus';
/* For Modal*/
import { Modal } from 'react-bootstrap';
import ThreadModalBody from './components/ThreadModalBody';
import ThreadModalFooter from './components/ThreadModalFooter';
import ModalHeader from 'react-bootstrap/lib/ModalHeader';
/* other component*/
import { ButtonIcon } from 'base_components/RootButton';

const ThreadModal = styled(Modal)`
  .modal-dialog {
    width: 100%;
    height: 100%;
    margin: 0;

    .modal-header,
    modal-footer {
      border-bottom: 1px solid #dadada;
    }

    .modal-content {
      border-radius: 0;
      border: 0;
      min-height: 100vh;
      position: relative;
    }
  }
`;

// New Thread Component.
class Thread extends Component {
  constructor() {
    super();
    this.state = {
      showModal: false
    };
  }

  close = () => {
    this.setState({ showModal: false });
  };

  open = () => {
    this.setState({ showModal: true });
  };

  render() {
    return (
      <div>
        <ButtonIcon secondary onClick={this.open}>
          New Thread
          <i>
            <IconPlus />
          </i>
        </ButtonIcon>

        <ThreadModal show={this.state.showModal} onHide={this.close}>
          <ModalHeader closeButton />
          <ThreadModalBody thread={this.props.thread} />
          <ThreadModalFooter />
        </ThreadModal>
      </div>
    );
  }
}

Thread.propTypes = {
  thread: PropTypes.object.isRequired
};

export default Thread;
