import styled from 'styled-components';

export default WrappedComponent =>
  styled(WrappedComponent)`
    background: #f5f5f5;
    height: 100vh;
    position: relative;

    .Login__formContainer {
      width: 80%;
      height: 300px;
      padding: 2em;
      background-color: #ffffff;
      box-shadow: 0px 3px 29px 0px rgba(214, 214, 214, 0.67);
      position: absolute;
      top: 35%;
      left: 50%;
      transform: translate(-50%, -50%);

      h3 {
        margin-top: 0.4em;
        margin-bottom: 0.6em;
        font-size: 1.8rem;
        font-weight: 800;
      }

      span {
        color: #ef2525;
        margin-bottom: 0.7em;
        display: block;
      }

      form {
        display: flex;
        flex-direction: column;

        input {
          font-size: 1rem;
          padding: 0.6em;
          border: 1px solid #c5c5c5;
          margin-bottom: 0.6em;
        }

        button {
          width: 100%;
          font-size: 1rem;
          border-radius: 0;
        }
      }
    }

    @media screen and (min-width: 768px) {
      .Login__formContainer {
        width: 30%;
      }
    }
  `;
