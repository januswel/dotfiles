// @flow

import React from 'react'

const styles = {
  container: {
    padding: 8,
    margin: 8,
  },
}

type Props = {
  foo: string,
  bar: number,
}
type State = {
  value: string,
}

export class Foo extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props)

    this.state = {
      value: 'initial value',
    }
  }

  onChange(event: SyntheticInputEvent<EventTarget>) {
    this.setState({
      value: event.target.value,
    })
  }

  render() {
    return <input value={this.state.value} onChange={this.onChange.bind(this)} />
  }
}

export default (props: Props) => (
  <div style={styles.container}>
    <p>{props.foo}</p>
    <p>{props.bar}</p>
  </div>
)
